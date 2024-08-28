#!/usr/bin/python3

import rospy
import numpy

from mrs_msgs.msg import ControlManagerDiagnostics,Reference
from mrs_msgs.srv import PathSrv,PathSrvRequest
from std_srvs.srv import Trigger,TriggerRequest

class Node:

    # #{ __init__(self)

    def __init__(self):

        rospy.init_node("sweeping_generator", anonymous=True)

        ## | --------------------- load parameters -------------------- |

        self.frame_id = rospy.get_param("~frame_id")

        self.distance = rospy.get_param("~distance")

        self.timer_main_rate = rospy.get_param("~timer_main/rate")

        rospy.loginfo('[RoboflyExample]: initialized')

        ## | ----------------------- subscribers ---------------------- |

        self.sub_control_manager_diag = rospy.Subscriber("~control_manager_diag_in", ControlManagerDiagnostics, self.callbackControlManagerDiagnostics)

        ## | --------------------- service clients -------------------- |

        self.sc_path = rospy.ServiceProxy('~path_out', PathSrv)

        self.sc_land = rospy.ServiceProxy('~land_out', Trigger)

        ## | ------------------------- timers ------------------------- |

        self.timer_main = rospy.Timer(rospy.Duration(1.0/self.timer_main_rate), self.timerMain)

        ## | -------------------- spin till the end ------------------- |

        self.is_initialized = True

        self.started = False
        self.finished = False

        rospy.spin()

    # #} end of __init__()

    ## | ------------------------- methods ------------------------ |

    # #{ planPath()

    def planPath(self):

        rospy.loginfo('[RoboflyExample]: planning path')

        # https://ctu-mrs.github.io/mrs_msgs/srv/PathSrv.html
        # -> https://ctu-mrs.github.io/mrs_msgs/msg/Path.html
        path_msg = PathSrvRequest()

        path_msg.path.header.frame_id = self.frame_id
        path_msg.path.header.stamp = rospy.Time.now()

        path_msg.path.fly_now = True

        path_msg.path.use_heading = True

        # https://ctu-mrs.github.io/mrs_msgs/msg/Reference.html
        point1 = Reference()

        point1.position.x = self.distance
        point1.position.y = 0
        point1.position.z = 0
        point1.heading = 0.0

        path_msg.path.points.append(point1)

        point2 = Reference()

        point2.position.x = -self.distance
        point2.position.y = 0
        point2.position.z = 0
        point2.heading = 0.0

        path_msg.path.points.append(point2)

        point3 = Reference()

        point3.position.x = 0
        point3.position.y = 0
        point3.position.z = 0
        point3.heading = 0.0

        path_msg.path.points.append(point3)

        return path_msg

    # #} end of planPath()

    # #{ land()

    def land(self):

        rospy.loginfo('[RoboflyExample]: landing')

        land_srv = TriggerRequest()

        try:
            response = self.sc_land.call(land_srv)
        except:
            rospy.logerr('[RoboflyExample]: land service not callable')
            pass

    # #} end of planPath()

    ## | ------------------------ callbacks ----------------------- |

    # #{ callbackControlManagerDiagnostics():

    def callbackControlManagerDiagnostics(self, msg):

        if not self.is_initialized:
            return

        rospy.loginfo_once('[RoboflyExample]: getting ControlManager diagnostics')

        self.sub_control_manager_diag = msg

    # #} end of

    ## | ------------------------- timers ------------------------- |

    # #{ timerMain()

    def timerMain(self, event=None):

        if not self.is_initialized:
            return

        rospy.loginfo_once('[RoboflyExample]: main timer spinning')

        if isinstance(self.sub_control_manager_diag, ControlManagerDiagnostics):

            if self.sub_control_manager_diag.flying_normally and not self.started and not self.finished:

                path_msg = self.planPath()

                try:
                    response = self.sc_path.call(path_msg)
                except:
                    rospy.logerr('[RoboflyExample]: path service not callable')
                    pass

                if response.success:
                    rospy.loginfo('[RoboflyExample]: path set')
                else:
                    rospy.loginfo('[RoboflyExample]: path setting failed, message: {}'.format(response.message))

                self.started = True

                return

            if self.started and not self.sub_control_manager_diag.tracker_status.have_goal and not self.finished:

                self.land()

                self.finished = True

                return

    # #} end of timerMain()

if __name__ == '__main__':
    try:
        node = Node()
    except rospy.ROSInterruptException:
        pass
