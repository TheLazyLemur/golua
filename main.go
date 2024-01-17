package main

import (
	"embed"
	"fmt"
	"os"

	lua "github.com/yuin/gopher-lua"
)

//go:embed lua/*
var embeddedContent embed.FS

func main() {
	L := lua.NewState()
	defer L.Close()

	setGlobals(L, getFunctionMap(L))

	currentDir, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current working directory:", err)
		return
	}

	s, err := os.MkdirTemp("", "luafun")
	if err != nil {
		panic(err)
	}

	defer func() {
		if err := os.Chdir(currentDir); err != nil {
			panic(err)
		}

		if err := os.RemoveAll(s); err != nil {
			panic(err)
		}
	}()

	if err := copyEmbeddedDir(s, "lua"); err != nil {
		panic(err)
	}

	if err := os.Chdir(s); err != nil {
		panic(err)
	}

	if err := L.DoFile("main.lua"); err != nil {
		panic(err)
	}
}
