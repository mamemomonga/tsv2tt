# タブ区切りのテキストをMarkdown,Backlog のテーブルに変換する

* タブ区切りのテキストをMarkdown,Backlogのテーブルに変換します。
* セル内の改行は\<br\>に変換されます。

## 実行環境

* Perl 5.6以降
* Carton または Text::CSV

## オプション

* --markdown, -m  Markdownのテーブルに変換
* --backoog,  -b  backlogのテーブルに変換
* --zspacer,  -z  空欄に全角スペースを入れる
* --help,     -h  このメッセージを表示する

## 使用例

以下はOSXでの使用例です。

### ExcelシートのテーブルをコピーしたものをMarkdownに変換して空欄は全角スペースで埋めるてペーストボードに戻す

	$ pbpaste | carton exec ./tsv2tt.pl --markdown --zspacer | pbcopy

### Excelシートのテーブルをコピーしたものをいったん data.tsv に保存して その後Backlog形式に変換し手ペーストボードにコピーする。

	$ cat > data.tsv
	$ cat data.tsv | carton exec ./tsv2tt.pl --backlog --zspacer | pbcopy

