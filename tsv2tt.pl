#!/usr/bin/env perl
use feature 'say';
use strict;
use warnings;
use utf8;

binmode(STDIN, ':utf8');
binmode(STDOUT,':utf8');
binmode(STDERR,':utf8');

use Getopt::Long;
use Text::CSV;

my %opts;
GetOptions(
	"markdown|m" => \$opts{markdown},
	"backlog|b"  => \$opts{backlog},
	"zspacer|z"  => \$opts{zspacer},
	"help|h"     => \$opts{help},
);

my $spacer="";
$spacer="　" if ($opts{zspacer});

if($opts{markdown}) {
	markdown();
} elsif ($opts{backlog}) {
	backlog();
} else {
	help();
}

sub help {
	say "[使用例]";
   	say "  cat tsvfile.tsv | tsv2tt.pl --markdown";
   	say "  pbpaste | tsv2tt.pl --markdown | pbcopy";
	say "";
	say "[オプション]";
	say "  --markdown, -m  Markdownのテーブルに変換";
	say "  --backoog,  -b  backlogのテーブルに変換";
	say "  --zspacer,  -z  空欄に全角スペースを入れる";
	say "  --help,     -h  このメッセージを表示する";
	exit(2);
}

sub read_table {
	my @table=();
	my $buf="";
	my $csv=Text::CSV->new({
		quote_char          => '"',
		escape_char         => '"',
		sep_char            => "\t",
		binary              => 1,
	});

	my @datas=();
	while(my $row=$csv->getline(*STDIN)) {
		push @datas,$row;
	}
	return \@datas;
}

# sub read_table {
# 	my @table=();
# 	while(<STDIN>) {
# 		s/\r|\n//g;
# 		if($_ ne '') {
# 			push @table,[split(/\t/)];
# 		}
# 	}
# 	return \@table;
# }

sub markdown {
	my @table=@{read_table()};
	my $flag=0;
	my $indexnum=$#{$table[0]};
	foreach my $tbl(@table) {
		my @tb=();
		for(my $i=0;$i<=$indexnum;$i++) {
			push @tb,$tbl->[$i] || $spacer;
		}
		my $buf=join(" | ",@tb);
		$buf=~s/\n/ <br> /g;
		say $buf;
		if(!$flag) {
			my $line=$buf;
			$line=~s/[^|]/-/g;
			say $line;
			$flag=1;
		}
	}
}

sub backlog {
	my @table=@{read_table()};
	my $flag=0;
	my $indexnum=$#{$table[0]};
	foreach my $tbl(@table) {
		my @tb=();
		for(my $i=0;$i<=$indexnum;$i++) {
			push @tb,$tbl->[$i] || $spacer;
		}
		my $buf='| '.join(" | ",@tb).' |';
		if(!$flag) {
			say $buf."h";
			$flag=1;
		} else {
			say $buf;
		}
	}
}
