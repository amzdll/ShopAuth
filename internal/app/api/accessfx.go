package api

import "go.uber.org/fx"

func accessModule() fx.Option {
	return fx.Module(
		"Access",
	)
}
