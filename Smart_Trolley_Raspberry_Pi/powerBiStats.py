import random
import time

from azure.iot.device import IoTHubDeviceClient, Message


CONNECTION_STRING = "<YOUR CONNECTION_STRING>"

MSG_TXT = '{{"productCount": {productCount}}}'

def iothub_client_init():
    # Create an IoT Hub client
    client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
    return client

def iothub_client_telemetry_sample_run(count):

    try:
        client = iothub_client_init()
        while True:
            msg_txt_formatted = MSG_TXT.format(productCount= count)
            message = Message(msg_txt_formatted)
            # Send the message.
            print( "Sending message: {}".format(message) )
            client.send_message(message)
            print ( "Message successfully sent" )
            time.sleep(3600)


    except KeyboardInterrupt:
        print ( "IoTHubClient sample stopped" )

if __name__ == '__main__':

    iothub_client_telemetry_sample_run('<Send count of the products bought, to this function>')
