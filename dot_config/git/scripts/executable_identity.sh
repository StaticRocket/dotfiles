#!/bin/sh

exec printf '%s <%s>' \
	"$(git config get user.name)" \
	"$(git config get user.email)"
