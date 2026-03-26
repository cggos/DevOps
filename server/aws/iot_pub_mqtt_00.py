# pip install awscrt awsiotsdk
# ref: https://github.com/aws/aws-iot-device-sdk-python-v2
# https://github.com/aws/aws-iot-device-sdk-python-v2/blob/main/samples/pubsub.py

import threading

from awscrt import mqtt
from awsiot import mqtt_connection_builder

# mqtt = mqtt.Client()
# mqtt.connect("localhost", 8883, 60)  # 1883

received_count = 0
received_all_event = threading.Event()

input_clientId = "xxx"
input_port = 8883
input_endpoint = "a1zr96a51e1tc0-ats.iot.us-east-1.amazonaws.com"
input_ca = ("AmazonRootCA1.pem")
input_cert = "2af96a182df4feea6f2076fd47db92a4874777ac8dc8b8d93d89691254d11dca-certificate.pem.crt"
input_key = "2af96a182df4feea6f2076fd47db92a4874777ac8dc8b8d93d89691254d11dca-private.pem.key"


# Callback when connection is accidentally lost.
def on_connection_interrupted(connection, error, **kwargs) -> None:
    pass


# Callback when an interrupted connection is re-established.
def on_connection_resumed(connection, return_code, session_present, **kwargs) -> None:
    if return_code == mqtt.ConnectReturnCode.ACCEPTED and not session_present:
        resubscribe_future, _ = connection.resubscribe_existing_topics()

        # Cannot synchronously wait for resubscribe result because we're on the connection's event-loop thread,
        # evaluate result with a callback instead.
        # resubscribe_future.add_done_callback(on_resubscribe_complete)


# Callback when the subscribed topic receives a message
def on_message_received(topic, payload, dup, qos, retain, **kwargs) -> None:
    global received_count
    received_count += 1
    # if received_count == cmdData.input_count:
    #     received_all_event.set()


# Callback when the connection successfully connects
def on_connection_success(connection, callback_data) -> None:
    assert isinstance(callback_data, mqtt.OnConnectionSuccessData)


# Callback when a connection attempt fails
def on_connection_failure(connection, callback_data) -> None:
    assert isinstance(callback_data, mqtt.OnConnectionFailureData)


# Callback when a connection has been disconnected or shutdown successfully
def on_connection_closed(connection, callback_data) -> None:
    pass


if __name__ == "__main__":
    # mqtt_connection = mqtt_connection_builder.mtls_from_path(
    #     endpoint=args.endpoint,
    #     cert_filepath=args.cert,
    #     pri_key_filepath=args.key,
    #     ca_filepath=args.ca_file,
    #     client_bootstrap=client_bootstrap,
    #     on_connection_interrupted=on_connection_interrupted,
    #     on_connection_resumed=on_connection_resumed,
    #     client_id=args.client_id,
    #     clean_session=False,
    #     keep_alive_secs=6,
    # )

    # Create a MQTT connection from the command line data
    mqtt_connection = mqtt_connection_builder.mtls_from_path(
        endpoint=input_endpoint,
        port=input_port,
        cert_filepath=input_cert,
        pri_key_filepath=input_key,
        ca_filepath=input_ca,
        client_id=input_clientId,
        clean_session=False,
        keep_alive_secs=30,
        # http_proxy_options=proxy_options,
        on_connection_interrupted=on_connection_interrupted,
        on_connection_resumed=on_connection_resumed,
        on_connection_success=on_connection_success,
        on_connection_failure=on_connection_failure,
        on_connection_closed=on_connection_closed,
    )

    connect_future = mqtt_connection.connect()
    # Future.result() waits until a result is available
    connect_future.result()

    # Wait for all messages to be received.
    # This waits forever if count was set to 0.
    # if message_count != 0 and not received_all_event.is_set():
    #     print("Waiting for all messages to be received...")

    received_all_event.wait()

    # Disconnect
    disconnect_future = mqtt_connection.disconnect()
    disconnect_future.result()
