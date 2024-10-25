export ROS_MASTER_URI=http://uav85:11311
export ROS_IP=192.168.12.11
unset ROS_HOSTNAME

rosrun rviz rviz -d ./camera_test.rviz
