
import os

settings = {
  'host': os.environ.get('ACCOUNT_HOST', '<YOUR ACCOUNT HOST>'),
  'master_key': os.environ.get('ACCOUNT_KEY', '<YOUR MASTER KEY>'),
  'database_id': os.environ.get('COSMOS_DATABASE', 'ShopAsAI'),
  'container_id': os.environ.get('COSMOS_CONTAINER', 'products'),
}
