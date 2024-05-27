package config

import (
	"go.uber.org/config"
)

type PGConfig struct {
	Name        string `yaml:"name"`
	User        string `yaml:"user"`
	Password    string `yaml:"password"`
	Host        string `yaml:"host"`
	Port        string `yaml:"port"`
	SslMode     string `yaml:"ssl_mode"`
	DsnTemplate string `yaml:"dsn_template"`
}

func NewPgConfig(provider config.Provider) (*PGConfig, error) {
	var c PGConfig
	if err := provider.Get("pg").Populate(&c); err != nil {
		return nil, err
	}
	return &c, nil
}
