#!/usr/bin/python3

import rospy
import rosnode
import math

from sensor_msgs.msg import Imu as Imu
from mavros_msgs.srv import CommandBool as CommandBool
from std_srvs.srv import Trigger as Trigger
from mrs_msgs.msg import HwApiStatus as HwApiStatus

class Activator:

    def callback(self, data):

        rospy.loginfo_once("getting data")
        
        accel = math.sqrt(math.pow(data.linear_acceleration.x, 2) + math.pow(data.linear_acceleration.y, 2) + math.pow(data.linear_acceleration.z, 2))

        rospy.loginfo_throttle(1.0, 'accel = {}'.format(accel))

        if accel < 2:
            # rospy.loginfo('arming')
            # self.arm(1)
            rospy.loginfo('activating')
            self.activate()
            rospy.signal_shutdown("yes")

    def __init__(self):

        rospy.init_node('activator', anonymous=True)

        uav_name = "uav80"

        self.subscriber = rospy.Subscriber('/' + uav_name + '/hw_api/imu', Imu, self.callback)
        self.subscriber = rospy.Subscriber('/' + uav_name + '/hw_api/status', HwApiStatus, self.callback)

        self.activate = rospy.ServiceProxy('/' + uav_name + '/uav_manager/midair_activation', Trigger)

        rospy.loginfo('initialized')

        rospy.spin()

if __name__ == '__main__':
    try:
        node_crash_checker = Activator()
    except rospy.ROSInterruptException:
        pass
