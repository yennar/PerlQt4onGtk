package Qt::QAbstractContainer;
use parent 'Qt::QAbstractWidget';
use Qt::QVBoxLayout;
use strict;
use warnings;

use strict;
use Glib qw/TRUE FALSE/;
use Gtk2;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->setLayout(Qt::QVBoxLayout->new());
    return $self;    
}

sub setLayout {
    my $self = shift;
    my $layout = shift;
    
    if (!$layout->is('QAbstractLayout')) {
        print STDERR "Qt::Widget->setLayout : parameter 2 must have meta type 'QAbstractLayout'\n";
        return;
    }
    $layout->pack_widget();
    $self->attach($layout->gtkobj());
    $self->{layout} = $layout;
}



1;


