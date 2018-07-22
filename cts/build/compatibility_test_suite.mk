# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Builds a compatibility test suite.
#

# Generate the SuiteInfo.java
suite_info_java := $(call intermediates-dir-for,JAVA_LIBRARIES,$(LOCAL_MODULE),true,COMMON)/com/android/compatibility/SuiteInfo.java
$(suite_info_java): PRIVATE_SUITE_BUILD_NUMBER := $(LOCAL_SUITE_BUILD_NUMBER)
$(suite_info_java): PRIVATE_SUITE_TARGET_ARCH := $(LOCAL_SUITE_TARGET_ARCH)
$(suite_info_java): PRIVATE_SUITE_NAME := $(LOCAL_SUITE_NAME)
$(suite_info_java): PRIVATE_SUITE_FULLNAME := $(LOCAL_SUITE_FULLNAME)
$(suite_info_java): PRIVATE_SUITE_VERSION := $(LOCAL_SUITE_VERSION)
$(suite_info_java): cts/build/compatibility_test_suite.mk $(LOCAL_MODULE_MAKEFILE)
	@echo Generating: $@
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "/* This file is auto generated by Android.mk.  Do not modify. */" > $@
	$(hide) echo "package com.android.compatibility;" >> $@
	$(hide) echo "public class SuiteInfo {" >> $@
	$(hide) echo "    public static final String BUILD_NUMBER = \"$(PRIVATE_SUITE_BUILD_NUMBER)\";" >> $@
	$(hide) echo "    public static final String TARGET_ARCH = \"$(PRIVATE_SUITE_TARGET_ARCH)\";" >> $@
	$(hide) echo "    public static final String NAME = \"$(PRIVATE_SUITE_NAME)\";" >> $@
	$(hide) echo "    public static final String FULLNAME = \"$(PRIVATE_SUITE_FULLNAME)\";" >> $@
	$(hide) echo "    public static final String VERSION = \"$(PRIVATE_SUITE_VERSION)\";" >> $@
	$(hide) echo "}" >> $@

# Reset variables
LOCAL_SUITE_BUILD_NUMBER :=
LOCAL_SUITE_NAME :=
LOCAL_SUITE_FULLNAME :=
LOCAL_SUITE_VERSION :=

# Include the SuiteInfo.java
LOCAL_GENERATED_SOURCES := $(suite_info_java)

# Add the base libraries
LOCAL_JAVA_LIBRARIES += tradefed-prebuilt hosttestlib compatibility-host-util

LOCAL_MODULE_TAGS := optional

include $(BUILD_HOST_JAVA_LIBRARY)
