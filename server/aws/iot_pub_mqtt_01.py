import argparse
import json
import time
from uuid import uuid4

from awscrt import io, mqtt
from awsiot import mqtt_connection_builder


def make_parser():
    parser = argparse.ArgumentParser(
        description="Send and receive messages through and MQTT connection.",
    )
    parser.add_argument(
        "endpoint",
        help="Your AWS IoT custom endpoint, not including a port.",
    )
    parser.add_argument(
        "--port",
        type=int,
        help="Specify port. AWS IoT supports 443 and 8883.",
        metavar="",
    )
    parser.add_argument(
        "--cert",
        help="File path to your client certificate, in PEM format.",
        metavar="",
    )
    parser.add_argument(
        "--key",
        help="File path to your private key, in PEM format.",
        metavar="",
    )
    parser.add_argument(
        "--root-ca",
        help="File path to root certificate authority, in PEM format.",
        metavar="",
    )
    parser.add_argument(
        "--client-id",
        default="test-" + str(uuid4()),
        help="Client ID for MQTT connection.",
        metavar="",
    )
    parser.add_argument(
        "--topic",
        default="test/topic",
        help="Topic to subscribe to, and publish messages to.",
        metavar="",
    )
    parser.add_argument(
        "--message",
        default="Hello World!",
        help="Message to publish. ",
        metavar="",
    )
    parser.add_argument(
        "--count",
        default=10,
        type=int,
        help="Number of messages to publish.",
        metavar="",
    )
    return parser


class IoT:
    def __init__(self, args) -> None:
        self.endpoint = args.endpoint
        self.port = args.port
        self.cert = args.cert
        self.key = args.key
        self.root_ca = args.root_ca
        self.client_id = args.client_id
        self.topic = args.topic
        self.message = args.message
        self.count = args.count

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
        )
        connect_future = self.mqtt_connection.connect()
        connect_future.result()

    def __exit__(self, exception_type, exception_value, traceback):
        disconnect_future = self.mqtt_connection.disconnect()
        disconnect_future.result()

    def subscribe(self) -> None:
        subscribe_future, packet_id = self.mqtt_connection.subscribe(
            topic=self.topic,
            qos=mqtt.QoS.AT_LEAST_ONCE,
            callback=self.on_message_recieved,
        )
        subscribe_future.result()

    def on_message_recieved(self, topic, paylod, dup, qos, retain, **kwargs) -> None:
        pass

    def publish(self) -> None:
        if self.message:
            message = f"{self.message} [{self.count}]"
            message_json = json.dumps(message)
            self.mqtt_connection.publish(
                topic=self.topic,
                payload=message_json,
                qos=mqtt.QoS.AT_LEAST_ONCE,
            )
            time.sleep(1)  # thought this might fix things, it did not


if __name__ == "__main__":
    parser = make_parser()
    args = parser.parse_args()
    iot_connection = IoT(args)
    with iot_connection:
        iot_connection.subscribe()  # subscribing to topic
        iot_connection.publish()  # publishing message hopefully
