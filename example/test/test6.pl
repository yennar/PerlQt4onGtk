#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib';
use Data::Dumper;

use Qt4OnGtk;


sub main {
    my $a = QApplication();
    my $w = QWidget();
    
    my $menu_bar = QMenuBar();
    my $menu_file = QMenu('File');
    $menu_file->addAction('Open',sub {print STDERR 'open'});
    $menu_file->addAction('Save',sub {print STDERR 'save'});
    $menu_file->addAction('Perference...',sub {print STDERR 'Perference'});
    $menu_bar->addMenu($menu_file);
    $menu_bar->addMenu(QMenu('Edit'));
    $menu_bar->addMenu(QMenu('Help'));
    $w->setMenuBar($menu_bar);
    
    $w->show();
    return $a->exec();
    
}

main();
