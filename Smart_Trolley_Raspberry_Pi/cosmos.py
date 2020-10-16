import azure.cosmos.documents as documents
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey
import datetime
import checkExpiry
import config
import textToSpeech


HOST = config.settings['host']
MASTER_KEY = config.settings['master_key']
DATABASE_ID = config.settings['database_id']
CONTAINER_ID = config.settings['container_id']




def read_itemProduct(container, doc_id, partionKey):
    print('\n1.2 Reading Item by Id\n')


    response = container.read_item(item=doc_id, partition_key=partionKey)
    month = response.get('month')
    day = response.get('day')
    year = response.get('year')
    if(checkExpiry.check(int(year),int(month),int(day)) == False):
        print('Item read by Id {0}'.format(doc_id))
        print('Name: {0}'.format(response.get('name')))
        return str(response.get('sex'))

def read_itemCustomer(container, doc_id, partionKey):
    print('\n1.2 Reading Item by Id\n')


    response = container.read_item(item=doc_id, partition_key=partionKey)
    print('Name: {0}'.format(response.get('Name')))
    return str(response.get('Sex'))



def upsert_item(container, doc_id, partionKey,productId):
    print('\n1.6 Upserting an item\n')

    read_item = container.read_item(item=doc_id, partition_key=partionKey)
    tempList = read_item['cart']
    tempList.append(productId)
    print(tempList)
    read_item['cart'] = tempList
    response = container.upsert_item(body=read_item)


def azureCosmos(customerId,productId):
    client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY}, user_agent="CosmosDBDotnetQuickstart", user_agent_overwrite=True)
    try:

        try:

            database_name = 'ShopAsAI'
            database = client.create_database_if_not_exists(id=database_name)

        except exceptions.CosmosResourceExistsError:
            print('CosmosResourceExistsError')
            pass


        try:
            containerProduct = database.create_container_if_not_exists(
                id = 'products',
                partition_key=PartitionKey(path="/productId"),
                offer_throughput=400
            )

            containerCustomer = database.create_container_if_not_exists(
                id = 'customers',
                partition_key=PartitionKey(path="/productId"),
                offer_throughput=400
            )

        except exceptions.CosmosResourceExistsError:
            print('Container with id \'{0}\' was found'.format(CONTAINER_ID))


        #slight gender based recommendations are made
        recommend = read_itemProduct(containerProduct, productId, productId)
        userRecommend = read_itemCustomer(containerCustomer, customerId, customerId)
        print(recommend,userRecommend)
        if(recommend =='M' and userRecommend == 'F'):
            textToSpeech.botSpeaks('Sorry Mam, its for Men,Try using others')
        elif(recommend =='F' and userRecommend == 'M'):
            textToSpeech.botSpeaks('Sorry Sir, its for Women, Try using others')
        elif(recommend !=None):
            print('fine')
            upsert_item(containerCustomer,  customerId,  customerId,productId)
            textToSpeech.botSpeaks('Item added to Cart!!')


    except exceptions.CosmosHttpResponseError as e:
        print('\nrun_sample has caught an error. {0}'.format(e.message))

    finally:
            print("\nrun_sample done")
