package main

import (
	"fmt"
	"os"
	"path/filepath"
	"time"

	rl "github.com/gen2brain/raylib-go/raylib"
	lua "github.com/yuin/gopher-lua"
)

func getRandomValue(L *lua.LState) int {
	low := int(L.CheckNumber(1))
	high := int(L.CheckNumber(2))

	rn := rl.GetRandomValue(int32(low), int32(high))
	L.Push(lua.LNumber(rn))
	return 1
}

func getScreenWidth(L *lua.LState) int {
	L.Push(lua.LNumber(rl.GetScreenWidth()))
	return 1
}

func getScreenHeight(L *lua.LState) int {
	L.Push(lua.LNumber(rl.GetScreenHeight()))
	return 1
}

func initWindow(L *lua.LState) int {
	rl.InitWindow(800, 450, "raylib [core] example - basic window")
	return 0
}

func windowShouldClose(L *lua.LState) int {
	if rl.WindowShouldClose() {
		L.Push(lua.LBool(true))
	} else {
		L.Push(lua.LBool(false))
	}
	return 1
}

func beginDrawing(L *lua.LState) int {
	rl.BeginDrawing()
	return 0
}

func endDrawing(L *lua.LState) int {
	rl.EndDrawing()
	return 0
}

func getKeyPressed(L *lua.LState) int {
	keyCode := L.CheckNumber(1)
	if rl.IsKeyPressed(int32(keyCode)) {
		L.Push(lua.LBool(true))
	} else {
		L.Push(lua.LBool(false))
	}
	return 1
}

func getKeyDown(L *lua.LState) int {
	keyCode := L.CheckNumber(1)

	if rl.IsKeyDown(int32(keyCode)) {
		L.Push(lua.LBool(true))
	} else {
		L.Push(lua.LBool(false))
	}

	return 1
}

func drawText(L *lua.LState) int {
	txt := L.CheckString(1)
	x := int32(L.CheckNumber(2))
	y := int32(L.CheckNumber(3))
	size := int32(L.CheckNumber(4))

	rl.DrawText(txt, x, y, size, rl.Red)
	return 0
}

func drawRec(L *lua.LState) int {
	x := L.CheckNumber(1)
	y := L.CheckNumber(2)
	width := L.CheckNumber(3)
	height := L.CheckNumber(4)

	v := rl.NewRectangle(float32(x), float32(y), float32(width), float32(height))
	rl.DrawRectangleRec(v, rl.Red)

	return 0
}

func clearBackground(L *lua.LState) int {
	r := L.CheckNumber(1)
	g := L.CheckNumber(2)
	b := L.CheckNumber(3)
	a := L.CheckNumber(4)

	rl.ClearBackground(rl.NewColor(uint8(r), uint8(g), uint8(b), uint8(a)))
	return 0
}

type Person struct {
	Name string
}

func setTargetFPS(L *lua.LState) int {
	t := L.CheckNumber(1)
	rl.SetTargetFPS(int32(t))
	return 0
}

func getdeltaTime(L *lua.LState) int {
	L.Push(lua.LNumber(rl.GetFrameTime()))
	return 1
}

func drawFPS(L *lua.LState) int {
	x := L.CheckNumber(1)
	y := L.CheckNumber(2)
	rl.DrawFPS(int32(x), int32(y))
	return 0
}

func closeWindow(L *lua.LState) int {
	rl.CloseWindow()
	return 0
}

func copyEmbeddedDir(targetDir, embeddedDir string) error {
	entries, err := embeddedContent.ReadDir(embeddedDir)
	if err != nil {
		return err
	}

	for _, entry := range entries {
		src := filepath.Join(embeddedDir, entry.Name())
		dst := filepath.Join(targetDir, entry.Name())

		if entry.IsDir() {
			err := copyEmbeddedDir(dst, src)
			if err != nil {
				return err
			}
		} else {
			fileContent, err := embeddedContent.ReadFile(src)
			if err != nil {
				return err
			}

			err = os.WriteFile(dst, fileContent, 0644)
			if err != nil {
				return err
			}
		}
	}

	return nil
}

func drawLine(L *lua.LState) int {
	x1 := L.CheckNumber(1)
	y1 := L.CheckNumber(2)
	x2 := L.CheckNumber(3)
	y2 := L.CheckNumber(4)

	rl.DrawLine(int32(x1), int32(y1), int32(x2), int32(y2), rl.Red)

	return 0
}

func sleep(L *lua.LState) int {
	time.Sleep(17 * time.Millisecond)
	fmt.Println("slept")
	return 0
}

func setGlobals(L *lua.LState, m map[string]lua.LValue) {
	for k, v := range m {
		L.SetGlobal(k, v)
	}
}

func getFunctionMap(L *lua.LState) map[string]lua.LValue {
	x := map[string]lua.LValue{}

	x["initWindow"] = L.NewFunction(initWindow)
	x["beginDrawing"] = L.NewFunction(beginDrawing)
	x["windowShouldClose"] = L.NewFunction(windowShouldClose)
	x["endDrawing"] = L.NewFunction(endDrawing)
	x["clearBackground"] = L.NewFunction(clearBackground)
	x["setTargetFPS"] = L.NewFunction(setTargetFPS)
	x["getDeltaTime"] = L.NewFunction(getdeltaTime)
	x["getScreenWidth"] = L.NewFunction(getScreenWidth)
	x["getScreenHeight"] = L.NewFunction(getScreenHeight)
	x["drawRec"] = L.NewFunction(drawRec)
	x["drawText"] = L.NewFunction(drawText)
	x["drawFPS"] = L.NewFunction(drawFPS)
	x["getKeyPressed"] = L.NewFunction(getKeyPressed)
	x["getKeyDown"] = L.NewFunction(getKeyDown)
	x["closeWindow"] = L.NewFunction(closeWindow)
	x["getRandomValue"] = L.NewFunction(getRandomValue)
	x["drawLine"] = L.NewFunction(drawLine)
	x["sleep"] = L.NewFunction(sleep)

	return x
}
