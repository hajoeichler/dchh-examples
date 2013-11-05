class sphere::mc(
  $mailjet_api_key=hiera("mailjet.api.key"),
  $sphere_mc_version=hiera("sphere.mc.version")) {

  package { "sphere-mc":
    ensure => $sphere_mc_version,
    notify => File["/etc/sphere-mc/application.conf"]
  }
  ->
  file { "/etc/sphere-mc/application.conf":
    ensure => present,
    owner => sphere, group => sphere, mode => 0600,
    content => template("sphere/application.conf.erb"),
    notify => Service["sphere-mc"]
  }
  ->
  service { "sphere-mc":
    ensure => running,
    enable => true
  }

}
