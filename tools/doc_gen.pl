#!/usr/bin/perl

use strict;
use warnings;

use App::Pod2CpanHtml;




my $resv_lib = '../lib/Qt';
my $resv_doc = '../doc';

opendir(my $dh, $resv_lib) || die "can't opendir $resv_lib: $!";
my @dots = readdir($dh);
closedir $dh;

my @mudules = ();

foreach (@dots) {
    if (/\.pm$/) {
        my $pod_file = "$resv_lib/$_";
        open IN, $pod_file;
        my $parser = App::Pod2CpanHtml->new();
        s/\.pm$//g;
        open OUT, ">$resv_doc/$_.html";
        
        $parser->output_fh(*OUT);        
        $parser->parse_file(*IN);      
        #s/\.pm$//g;
        #push @mudules,$_;
    }
}



opendir($dh, $resv_doc) || die "can't opendir $resv_doc: $!";
@dots = readdir($dh);
closedir $dh;

foreach (@dots) {
    if (/\.html$/) {
        my $pod_file = "$resv_doc/$_";
        #print "$pod_file\n";
        open IN, $pod_file;
        my @c = <IN>;
        my $c = join ("",@c);
        #print $c;
        $c =~ s/http:\/\/search\.cpan\.org\/perldoc\?//g;
        close IN;
        open OUT, ">$pod_file";
        
        print OUT $c;
        close OUT;    
        #s/\.pm$//g;
        #push @mudules,$_;
    }
}