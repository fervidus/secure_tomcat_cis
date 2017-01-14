# Runs any tomcat install
class secure_tomcat::run_instances {
  create_resources('::tomcat::instance', $::secure_tomcat::instances)

  create_resources('::tomcat::config::properties::property', $::secure_tomcat::config_properties_properties)
  create_resources('::tomcat::config::server', $::secure_tomcat::config_servers)
  create_resources('::tomcat::config::server::connector', $::secure_tomcat::config_server_connectors)
  create_resources('::tomcat::config::server::context', $::secure_tomcat::config_server_contexts)
  create_resources('::tomcat::config::server::engine', $::secure_tomcat::config_server_engines)
  create_resources('::tomcat::config::server::globalnamingresource', $::secure_tomcat::config_server_globalnamingresources)
  create_resources('::tomcat::config::server::host', $::secure_tomcat::config_server_hosts)
  create_resources('::tomcat::config::server::listener', $::secure_tomcat::config_server_listeners)
  create_resources('::tomcat::config::server::realm', $::secure_tomcat::config_server_realms)
  create_resources('::tomcat::config::server::service', $::secure_tomcat::config_server_services)
  create_resources('::tomcat::config::server::tomcat_users', $::secure_tomcat::config_server_tomcat_users)
  create_resources('::tomcat::config::server::valve', $::secure_tomcat::config_server_valves)
  create_resources('::tomcat::config::context', $::secure_tomcat::config_contexts)
  create_resources('::tomcat::config::context::environment', $::secure_tomcat::config_context_environments)
  create_resources('::tomcat::config::context::manager', $::secure_tomcat::config_context_managers)
  create_resources('::tomcat::config::context::resource', $::secure_tomcat::config_context_resources)
  create_resources('::tomcat::config::context::resourcelink', $::secure_tomcat::config_context_resourcelinks)
}
