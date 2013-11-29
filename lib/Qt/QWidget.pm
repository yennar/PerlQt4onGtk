package Qt::QWidget;
use parent 'Qt::QAbstractContainer';
 
use strict;
use warnings;

use strict;
use Glib qw/TRUE FALSE/;
use Gtk2;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    return $self;    
}

sub setMenuBar {
    my $self = shift;
    my $menubar = shift;
    
    return if (!defined $menubar);
    return if (!$menubar->is('QMenuBar'));
    
    $self->{layout}->insertWidget(0,$menubar);
    $self->{layout}->pack_widget();
}

1;


