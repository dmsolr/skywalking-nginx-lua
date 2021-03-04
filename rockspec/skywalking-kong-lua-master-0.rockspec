package = "skywalking-kong-lua"
version = "master-0"
source = {
   url = "git://github.com/apache/skywalking-nginx-lua",
   branch = "master",
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
      ["kong.plugins.skywalking.handler"] = "lib/skywalking/handler.lua",
      ["kong.plugins.skywalking.schema"] = "lib/skywalking/schema.lua",
      ["kong.plugins.skywalking.client"] = "lib/skywalking/client.lua",
      ["kong.plugins.skywalking.constants"] = "lib/skywalking/constants.lua",
      ["kong.plugins.skywalking.correlation_context"] = "lib/skywalking/correlation_context.lua",
      ["kong.plugins.skywalking.management"] = "lib/skywalking/management.lua",
      ["kong.plugins.skywalking.segment_ref"] = "lib/skywalking/segment_ref.lua",
      ["kong.plugins.skywalking.segment"] = "lib/skywalking/segment.lua",
      ["kong.plugins.skywalking.span_layer"] = "lib/skywalking/span_layer.lua",
      ["kong.plugins.skywalking.span"] = "lib/skywalking/span.lua",
      ["kong.plugins.skywalking.tracer"] = "lib/skywalking/tracer.lua",
      ["kong.plugins.skywalking.tracing_context"] = "lib/skywalking/tracing_context.lua",
      ["kong.plugins.skywalking.util"] = "lib/skywalking/util.lua",
   }
}
