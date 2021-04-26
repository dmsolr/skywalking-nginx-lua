--
-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

local pb = require("pb")
local protoc  = require("protoc")


assert(protoc:load [[
    syntax = "proto3";
    message KeyStringValuePair {
        string key = 1;
        string value = 2;
    }

    message CPU {
        double usagePercent = 2;
    }

    enum DetectPoint {
        client = 0;
        server = 1;
        proxy = 2;
    }

    message Commands {
        repeated Command commands = 1;
    }

    message Command {
        string command = 1;
        repeated KeyStringValuePair args = 2;
    }

    message InstanceProperties {
        string service = 1;
        string serviceInstance = 2;
        repeated KeyStringValuePair properties = 3;
    }

    message InstancePingPkg {
        string service = 1;
        string serviceInstance = 2;
    }

    message SegmentObject {
        string traceId = 1;
        string traceSegmentId = 2;
        repeated SpanObject spans = 3;
        string service = 4;
        string serviceInstance = 5;
        bool isSizeLimited = 6;
    }

    message SegmentReference {
        RefType refType = 1;
        string traceId = 2;
        string parentTraceSegmentId = 3;
        int32 parentSpanId = 4;
        string parentService = 5;
        string parentServiceInstance = 6;
        string parentEndpoint = 7;
        string networkAddressUsedAtPeer = 8;
    }

    message SpanObject {
        int32 spanId = 1;
        int32 parentSpanId = 2;
        int64 startTime = 3;
        int64 endTime = 4;
        repeated SegmentReference refs = 5;
        string operationName = 6;
        string peer = 7;
        SpanType spanType = 8;
        SpanLayer spanLayer = 9;
        int32 componentId = 10;
        bool isError = 11;
        repeated KeyStringValuePair tags = 12;
        repeated Log logs = 13;
        bool skipAnalysis = 14;
    }

    message Log {
        int64 time = 1;
        repeated KeyStringValuePair data = 2;
    }

    enum SpanType {
        Entry = 0;
        Exit = 1;
        Local = 2;
    }

    message ID {
        repeated string id = 1;
    }

    enum RefType {
        CrossProcess = 0;
        CrossThread = 1;
    }

    enum SpanLayer {
        Unknown = 0;
        Database = 1;
        RPCFramework = 2;
        Http = 3;
        MQ = 4;
        Cache = 5;
    }

    message SegmentCollection {
        repeated SegmentObject segments = 1;
    } ]])

local _M = {}

function _M.instance_properties_transform(instance_properties)
    return pb.encode("InstanceProperties", instance_properties)
end

function _M.instance_ping_transform(instance_properties)
    return pb.encode("InstancePingPkg", instance_properties)
end

function _M.segment_transform(segment)
    return pb.encode("SegmentObject", segment)
end

return _M