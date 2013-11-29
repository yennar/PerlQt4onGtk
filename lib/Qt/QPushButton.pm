package Qt::QPushButton;

use parent 'Qt::QAbstractButton';
 
use strict;
use warnings;

use strict;
use Gtk2;

sub new {
    my $class = shift;
    #instance arguments;
    my $text = shift;    
    my $self =  $class->SUPER::new(__PACKAGE__);
    $self->attach(Gtk2::Button->new ($text));
    
    return $self;    
}

1;


