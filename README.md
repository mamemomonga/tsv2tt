# タブ区切りのテキストをMarkdown,Backlog のテーブルに変換する

タブ区切りのテキストをMarkdown,Backlogのテーブルに変換します。

## 実行環境

Perl 5.6以降

## オプション

* --markdown, -m  Markdownのテーブルに変換
* --backoog,  -b  backlogのテーブルに変換
* --zspacer,  -z  空欄に全角スペースを入れる
* --help,     -h  このメッセージを表示する

## 使用例

ExcelシートのテーブルをコピーしたものをMarkdownに変換して空欄は全角スペースで埋めるてペーストボードに戻す

	$ pbpaste | ./tsv2tt.pl --markdown --zspacer | pbcopy


