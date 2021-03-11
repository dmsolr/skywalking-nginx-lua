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

local skywalking_tracer = require("kong.plugins.skywalking.tracer")
local skywalking_client = require("kong.plugins.skywalking.client")

local SkyWalkingHandler = {
    PRIORITY = 100001,
    VERSION = "0.0.1",
}

function SkyWalkingHandler:preread(config)
end

function SkyWalkingHandler:access(config)
    local metadata_buffer = ngx.shared.kong_db_cache
    metadata_buffer:set('serviceName', 'User_Service_Name')
    metadata_buffer:set('serviceInstanceName', 'User_Service_Instance_Name')
    metadata_buffer:set('includeHostInEntrySpan', false)

    require("kong.plugins.skywalking.util").set_randomseed()
    skywalking_client:startBackendTimer("http://47.74.186.96:12800")

    kong.log.info('access phase of skywalking plugin')
    skywalking_tracer:start("upstream service")
end

function SkyWalkingHandler:body_filter(config)
    kong.log.info('body_filterphase of skywalking plugin')
    if ngx.arg[2] then
        skywalking_tracer:finish()
    end
end

function SkyWalkingHandler:log(config)
    kong.log.info('log phase of skywalking plugin')
    skywalking_tracer:prepareForReport()
end

return SkyWalkingHandler