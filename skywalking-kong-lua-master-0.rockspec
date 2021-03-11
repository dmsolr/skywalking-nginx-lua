package = "skywalking-kong-lua"
version = "master-0"
source = {
   url = "git://github.com/dmsolr/skywalking-nginx-lua",
   branch = "kong",
}

description = {
   summary = "The Nginx Lua agent for Apache SkyWalking",
   homepage = "https://github.com/apache/skywalking-nginx-lua",
   license = "Apache License 2.0"
}

dependencies = {
   "lua-resty-http >= 0.15",
   "lua-resty-jit-uuid >= 0.0.7"
}

build = {
   type = "builtin",
   modules = {
      ["kong.plugins.skywalking.handler"] = "kong/plugins/skywalking/handler.lua",
      ["kong.plugins.skywalking.schema"] = "kong/plugins/skywalking/schema.lua",
      ["kong.plugins.skywalking.client"] = "kong/plugins/skywalking/client.lua",
      ["kong.plugins.skywalking.constants"] = "kong/plugins/skywalking/constants.lua",
      ["kong.plugins.skywalking.correlation_context"] = "kong/plugins/skywalking/correlation_context.lua",
      ["kong.plugins.skywalking.management"] = "kong/plugins/skywalking/management.lua",
      ["kong.plugins.skywalking.segment_ref"] = "kong/plugins/skywalking/segment_ref.lua",
      ["kong.plugins.skywalking.segment"] = "kong/plugins/skywalking/segment.lua",
      ["kong.plugins.skywalking.span_layer"] = "kong/plugins/skywalking/span_layer.lua",
      ["kong.plugins.skywalking.span"] = "kong/plugins/skywalking/span.lua",
      ["kong.plugins.skywalking.tracer"] = "kong/plugins/skywalking/tracer.lua",
      ["kong.plugins.skywalking.tracing_context"] = "kong/plugins/skywalking/tracing_context.lua",
      ["kong.plugins.skywalking.util"] = "kong/plugins/skywalking/util.lua",
   }
}
