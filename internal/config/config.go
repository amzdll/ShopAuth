package config

import (
	"go.uber.org/config"
	"go.uber.org/fx"
)

const (
	EnvLocal = "local"
	EnvDev   = "dev"
	EnvProd  = "prod"
)

type BaseConfig struct {
	Name string `yaml:"name"`
}

type Config struct {
	fx.Out
	Provider config.Provider
	Config   BaseConfig
}

func NewConfig() (Config, error) {
	loader, err := config.NewYAML(config.File("config/config.yaml"))
	if err != nil {
		return Config{}, err
	}
	baseConfig := BaseConfig{
		Name: "default",
	}
	if err = loader.Get("app").Populate(&baseConfig); err != nil {
		return Config{}, err
	}
	return Config{Provider: loader}, nil
}
