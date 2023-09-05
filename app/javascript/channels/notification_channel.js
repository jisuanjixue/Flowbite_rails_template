import consumer from "./consumer"
import CableReady from "cable_ready";

consumer.subscriptions.create("NotificationChannel", {
  received(data) {
    if (data.cableReady) CableReady.perform(data.operations);
  },
});
