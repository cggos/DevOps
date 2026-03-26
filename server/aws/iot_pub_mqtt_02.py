import json
import threading
import time

from awscrt import io, mqtt
from awsiot import mqtt_connection_builder

global received_all_event


class IoT:
    def __init__(self) -> None:
        self.client_id = "xxx"
        self.port = 8883
        self.endpoint = "a1zr96a51e1tc0-ats.iot.us-east-1.amazonaws.com"
        self.root_ca = "aws-iot-core-cert/sit/AmazonRootCA1.pem"
        self.cert = "aws-iot-core-cert/sit/2af96a182df4feea6f2076fd47db92a4874777ac8dc8b8d93d89691254d11dca-certificate.pem.crt"
        self.key = "aws-iot-core-cert/sit/2af96a182df4feea6f2076fd47db92a4874777ac8dc8b8d93d89691254d11dca-private.pem.key"

        self.count = 10
        self.topic = f"$aws/things/{self.client_id}/shadow/name/service/update"

    def __enter__(self):
        self.event_loop_group = io.EventLoopGroup(1)
        self.host_resolver = io.DefaultHostResolver(self.event_loop_group)
        self.client_bootstrap = io.ClientBootstrap(
            self.event_loop_group,
            self.host_resolver,
        )
        self.mqtt_connection = mqtt_connection_builder.mtls_from_path(
            endpoint=self.endpoint,
            port=self.port,
            cert_filepath=self.cert,
            pri_key_filepath=self.key,
            ca_filepath=self.root_ca,
            client_id=self.client_id,
            client_bootstrap=self.client_bootstrap,
            clean_session=False,
            keep_alive_secs=30,
            # on_connection_interrupted=self.on_connection_interrupted,
            # on_connection_resumed=self.on_connection_resumed,
            # on_connection_success=self.on_connection_success,
            # on_connection_failure=self.on_connection_failure,
            # on_connection_closed=self.on_connection_closed,
        )
        connect_future = self.mqtt_connection.connect()
        connect_future.result()

        threading.Event()

    def __exit__(self, exception_type, exception_value, traceback):
        disconnect_future = self.mqtt_connection.disconnect()
        disconnect_future.result()

    # Callback when connection is accidentally lost.
    def on_connection_interrupted(self, error, **kwargs) -> None:
        pass

    # Callback when an interrupted connection is re-established.
    def on_connection_resumed(self, return_code, session_present, **kwargs) -> None:
        if return_code == mqtt.ConnectReturnCode.ACCEPTED and not session_present:
            resubscribe_future, _ = self.resubscribe_existing_topics()

            # Cannot synchronously wait for resubscribe result because we're on the connection's event-loop thread,
            # evaluate result with a callback instead.
            # resubscribe_future.add_done_callback(on_resubscribe_complete)

    # Callback when the subscribed topic receives a message
    def on_message_received(self, payload, dup, qos, retain, **kwargs) -> None:
        global received_count
        received_count += 1
        if received_count == 5:
            received_all_event.set()

    # Callback when the connection successfully connects
    def on_connection_success(self, callback_data) -> None:
        assert isinstance(callback_data, mqtt.OnConnectionSuccessData)

    # Callback when a connection attempt fails
    def on_connection_failure(self, callback_data) -> None:
        assert isinstance(callback_data, mqtt.OnConnectionFailureData)

    # Callback when a connection has been disconnected or shutdown successfully
    def on_connection_closed(self, callback_data) -> None:
        pass

    def subscribe(self) -> None:
        subscribe_future, packet_id = self.mqtt_connection.subscribe(
            topic=self.topic,
            qos=mqtt.QoS.AT_LEAST_ONCE,
            callback=self.on_message_recieved,
        )
        subscribe_future.result()

    def publish(self) -> None:
        for _i in range(5):
            payload = {"state": {"desired": {"25141": {"1": 1}}}}
            pub_future, packet_id = self.mqtt_connection.publish(
                topic=self.topic,
                payload=json.dumps(payload),
                qos=mqtt.QoS.AT_LEAST_ONCE,
            )
            pub_future.result()
            # print("Result: {}".format(str(result["qos"])))
            time.sleep(0.1)  # thought this might fix things, it did not


if __name__ == "__main__":
    iot_connection = IoT()
    time.sleep(1)
    with iot_connection:
        # iot_connection.subscribe()  # subscribing to topic
        iot_connection.publish()  # publishing message hopefully
