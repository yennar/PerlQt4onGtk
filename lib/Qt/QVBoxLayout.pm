package Qt::QVBoxLayout;
use parent 'Qt::QAbstractBoxLayout';
 
use strict;
use warnings;

use strict;
use Gtk2;

=pod

=head1 B<Qt::QVBoxLayout>

=head2 DESCRIPTION

Inherits L<QAbstractBoxLayout>

=head2 EXAMPLE

    my $layout = QVBoxLayout();
    $layout->addWidget($button1);
    $layout->addWidget($button2);
    
    my $widget = QWidget();
    $widget->setLayout($layout);    

=cut

sub new {
    my $class = shift;
    my $self = $class->SUPER::new('QVBoxLayout');
    $self->attach(Gtk2::VBox->new (0,$self->{'spacing'})); 
    $self->{'direction'} = 'V';
    return $self;
}


1;


