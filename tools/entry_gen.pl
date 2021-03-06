#!/use/bin/perl -w

use strict;
use warnings;

my $output_file = '../lib/Qt4OnGtk.pm';
my $resv_lib = '../lib/Qt';

opendir(my $dh, $resv_lib) || die "can't opendir $resv_lib: $!";
my @dots = readdir($dh);
closedir $dh;

my @mudules = ();

foreach (@dots) {
    if (/Q[A-Z].+\.pm/ && ! /QAbstract/) {
        s/\.pm$//g;
        push @mudules,$_;
    }
}

open F,">$output_file" || die "can't open file $output_file: $!";
print F "#Automatically generated by entry_gen.pl\n";
print F "package Qt4OnGtk;\nuse strict;\nuse warnings;\n";
map { print F "use Qt::$_;\n" } @mudules;
print F "require Exporter;\nour \@ISA = qw(Exporter);\nour \@EXPORT = qw(";
print F join(' ',@mudules);
print F " QtGlobalObject);\n";
print F "our \$QtGlobalObject = Qt::QList->new();\n";
map { print F "sub $_ {\n    my \$o = Qt::$_->new(\@_);\n    my \$id = \$QtGlobalObject->append(\$o);\n    \$o->_set_id(\$id);\n    return \$o;\n}\n" } @mudules;
print F "package Qt;\nuse strict;\nuse warnings;\n1;\n\n";
close F;
