package Qt::QLineEdit;

use parent 'Qt::QAbstractLineEdit';
 
use strict;
use warnings;

use strict;
use Gtk2;

=pod

=head1 B<Qt::QLineEdit>

=head2 DESCRIPTION

The QLineEdit widget is a one-line text editor. 

=cut

sub new {
    my $class = shift;
    #instance arguments;
    my $text = shift;    
    my $self =  $class->SUPER::new('QLineEdit');
    $self->attach(Gtk2::Entry->new ());
    
    return $self;    
}

1;


