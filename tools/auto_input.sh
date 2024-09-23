#!/bin/bash

TYPES=("houshin" "soukatsu")
SECTIONS=("kaikei" "kensui" "soumu" "syogai" "system" "zentai")

for type in "${TYPES[@]}"
do
    # 各タイプ（houshin, soukatsu）のメインファイルを作成
    main_file="src/${type}.tex"
    echo "\\documentclass{article}" > "$main_file"
    echo "\\begin{document}" >> "$main_file"

    for section in "${SECTIONS[@]}"
    do
        # 所定ディレクトリ以下に含まれるtexファイルを取得してソート
        files=$(find "src/${type}/${section}" -type f -name "*.tex" | sort)
        
        if [ "$1" = "show" ]; then
            # 見つかったtexファイルのパスを出力
            echo "${files}"
        else
            # セクションごとにサブセクションを作成
            echo "\\section{${section^}}" >> "$main_file"

            # input文を生成し、メインファイルに追加
            if [ -n "$files" ]; then
                while IFS= read -r file; do
                    echo "\\input{${file}}" >> "$main_file"
                done <<< "$files"
            else
                echo "% No .tex files found in ${type}/${section}" >> "$main_file"
            fi

            echo "" >> "$main_file"  # 空行を追加
        fi
    done

    # ドキュメントを閉じる
    echo "\\end{document}" >> "$main_file"
done
