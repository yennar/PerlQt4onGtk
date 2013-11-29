#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib';

use Qt4OnGtk;


sub main {
    my $app = QApplication(\@ARGV);
    
    my $hello_button = QPushButton("Hello world!");
    my $quit_button = QPushButton("Quit");
    
    $hello_button->{clicked}->connect(sub {print STDERR "Hello Perl\n"});
    $quit_button->{clicked}->connect(sub {$app->quit() });
    
    my $layout = QHBoxLayout();
    $layout->addWidget($hello_button);
    $layout->addWidget($quit_button);
    
    my $widget = QWidget();
    $widget->setLayout($layout);    
    $widget->show();
    exit $app->exec();
}

main();
