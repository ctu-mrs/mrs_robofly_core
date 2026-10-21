cmake_minimum_required(VERSION 3.20)
project(mrs_robofly_core)

find_package(ament_cmake REQUIRED)

install(
  DIRECTORY config
  DESTINATION share/${PROJECT_NAME}
)

install(
  DIRECTORY deployment
  USE_SOURCE_PERMISSIONS
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
