package Qt::QApplication;
use parent 'Qt::QAbstractObject';

use strict;
use warnings;
use Data::Dumper;

=pod

=head1 B<Qt::QApplication>

=head2 DESCRIPTION

The QApplication manages the main event loop.

=head2 SYNOPSIS

A simple application:

    my $app = QApplication (\@ARGV);
    my $w = QWidget();
    $w->show();
    $app->exec();

=cut

sub new {
    my $class = shift;
    my @argv = ();
    foreach (@_) {
        push @argv,$_;
    }
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->{'argv'} = \@argv;
    return $self;
}

use Gtk2 -init;
 
sub exec {
    Gtk2->main;  
    return 0;
}

sub quit {
    return Gtk2->main_quit;
}

1;

