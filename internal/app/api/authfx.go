package api

import "go.uber.org/fx"

func authModule() fx.Option {
	return fx.Module(
		"Auth",
	)
}
