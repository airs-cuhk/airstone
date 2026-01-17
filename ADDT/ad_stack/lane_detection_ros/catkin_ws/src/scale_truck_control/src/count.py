#!/usr/bin/env python
import rospy
from sensor_msgs.msg import Image  # Adjust for the type of message you're subscribing to
import time

class FrameCounter:
    def __init__(self):
        self.frame_count = 0
        self.start_time = rospy.Time.now()
        rospy.init_node('frame_counter', anonymous=True)
        rospy.Subscriber("/carla/ego_vehicle/rgb_front/image", Image, self.callback)  # Update the topic name and message type as necessary

    def callback(self, data):
        self.frame_count += 1
        current_time = rospy.Time.now()
        elapsed = (current_time - self.start_time).to_sec()
        if elapsed >= 1.0:  # Update FPS every second
            fps = self.frame_count / elapsed
            rospy.loginfo("FPS: %f", fps)
            self.frame_count = 0
            self.start_time = rospy.Time.now()

    def run(self):
        rospy.spin()

if __name__ == '__main__':
    counter = FrameCounter()
    counter.run()

