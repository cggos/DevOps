
string(TIMESTAMP vTimeStamp "%Y%m%d%H%M%S")
execute_process(
  COMMAND git log -1 --format=%h
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  OUTPUT_VARIABLE vGitCommit
  OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
  COMMAND git rev-parse --abbrev-ref HEAD
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  OUTPUT_VARIABLE vGitBranch
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(PROJECT_NAME "app_name")

set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PROJECT_DESCRIPTION})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
set(CPACK_PACKAGE_RELEASE ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VENDOR "Chervon")

set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PLATFORM_ARCH}-${vTimeStamp}-${vGitBranch}-${vGitCommit}")

# set(CPACK_RPM_PACKAGE_GROUP "xxx")
# set(CPACK_RPM_PACKAGE_DESCRIPTION "xxx")

# 7Z (7-Zip file format)
# DEB (Debian packages)
# External (CPack External packages)
# IFW (Qt Installer Framework)
# NSIS (Null Soft Installer)
# NSIS64 (Null Soft Installer (64-bit))
# NuGet (NuGet packages)
# RPM (RPM packages)
# STGZ (Self extracting Tar GZip compression
# TBZ2 (Tar GZip compression)
# TXZ (Tar XZ compression)
# TZ (Tar Compress compression)
# ZIP (ZIP file format)
# set(CPACK_SOURCE_GENERATOR "TGZ;ZIP")
# set(CPACK_GENERATOR "TGZ;ZIP")
set(CPACK_GENERATOR "ZIP")

include(CPack)
