#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib';

use Qt4OnGtk;


sub main {
    my $app = QApplication(\@ARGV);
    
    my $edit1 = QLineEdit();
    my $edit2 = QLineEdit();
    my $incr_button = QPushButton("Incr String");
    my $quit_button = QPushButton("Quit");
    
    $incr_button->{clicked}->connect(sub {$edit2->setText($edit1->text() . $edit2->text())});
    $quit_button->{clicked}->connect(sub {$app->quit()});
                
    my $layout = QHBoxLayout();
    $layout->addWidget($edit1);
    $layout->addWidget($edit2);
    $layout->addWidget($incr_button);
    $layout->addWidget($quit_button);
    
    my $widget = QWidget();
    $widget->setLayout($layout);    
    $widget->show();
    exit $app->exec();
}

main();
