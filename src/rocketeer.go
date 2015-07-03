package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	concat()
}

func concat() {
	f, err := os.Create("rocketeer.dist.sh")
	check(err)
	defer f.Close()

	pwd, err := os.Getwd()
	check(err)

	fmt.Fprintln(f, "#!/usr/bin/env bash\n")

	dirs := []string{"utils", "php-dev", "js-dev"}

	for _, dir := range dirs {
		files, err := filepath.Glob(pwd + "/" + dir + "/*.sh")
		check(err)
		fmt.Println(files)

		for _, file := range files {
			openedScript, err := os.Open(file)
			check(err)

			defer openedScript.Close()

			openedScriptBufio := bufio.NewScanner(openedScript)

			for openedScriptBufio.Scan() {
				text := openedScriptBufio.Text()

				if !strings.HasPrefix(text, "#") {
					fmt.Println(text)
					fmt.Fprintln(f, text)
				}
			}
		}
	}
}
