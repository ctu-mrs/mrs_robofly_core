FROM ctumrs/mrs_uav_system:latest

ARG WORKSPACE_PATH="/etc/robofly/catkin_workspace"

# create catkin workspace
RUN mkdir -p ${WORKSPACE_PATH}/src
RUN cd ${WORKSPACE_PATH} && catkin init

# set workspace build profile
RUN cd ${WORKSPACE_PATH} && catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && catkin profile set reldeb && catkin config --extend /opt/ros/noetic 

# copy the sources from the local subfolder
COPY src/* ${WORKSPACE_PATH}/src

RUN cd ${WORKSPACE_PATH} && catkin build

CMD ["bash"]
