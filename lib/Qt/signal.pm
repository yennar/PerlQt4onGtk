package Qt::signal;

use strict;
use warnings;
use Gtk2;

=pod

=head1 B<Qt::signal>

=head2 DESCRIPTION

This module is used for emulating Qt signals.

=head2 SYNOPSIS

For instancing, use in pre-defined widgets using pre-defined signal I<some_signal>:

    $some_widget->{some_signal}->connect(some_slot_function);
    $some_widget->{some_signal}->connect(some_slot_function,parameter);
    $some_widget->{some_signal}->emit();
    $some_widget->{some_signal}->emit(parameter);

For subclassing, use in user defined widgets to define a signal named I<signal_name>:

    package MyWidget;
    use parent 'Qt::QAbstractWidget';
    
    sub new {
        my $class = shift;
        my $self = $class->SUPER::new(__PACKAGE__);
        $self->register_signal_map(['signal_name']);
        return $self;
    }


=head2 METHODS


=head3 new(owner,name)

Internal function. This method is only for contributers and should not be called at any time.

=over 2

=item *
I<owner> : the parent widget of this signal.

=item *
I<name>  : signal name. Same as Qt signal name for pre-defined widgets.

=back

=cut

sub new {
    my $class = shift;
    my $owner = shift;
    my $name = shift;
    my $self = {'owner' => $owner,'name' => $name,'proc' => []};
    bless $self, $class;
    return $self;    
}

=pod

=head3 connect(func,parameter_connect_time)

Connect this signal to I<func> with parameter I<parameter_connect_time>

This function prototype should be 

    sub func {
        my ($parameter_connect_time,$parameter_emit_time) = @_;
    } 

=over 2

=item *
I<parameter_connect_time> is evaluated when B<connect()> is called.

=item *
I<parameter_emit_time> is evaluated when B<emit()> is called.

=back

=cut

sub connect {
    my $self = shift;
    my $func = shift;
    my $parameter_connect_time = shift;
    if (defined $self->{'owner'}->{'_'}) {
        $self->{'owner'}->{'_'}->signal_connect(
            $self->{'name'} => sub {
                my ($o, $p) = @_;
                &$func($p,$self->{'owner'});
             }
            ,$parameter_connect_time
        );
    }
    push @{$self->{'proc'}},[$func,$parameter_connect_time];
}

=pod

=head3 emit(parameter_emit_time)

emit this signal with parameter I<parameter_emit_time>.
All functions connected to this signal are called in the order they are connected.

=cut



sub emit {
    my $self = shift;
    my $parameter_emit_time = shift;
    if (defined $self->{'proc'}) {
        foreach (@{$self->{'proc'}}) {
            my $func = $_->[0];
            my $parameter_connect_time = $_->[1];
            &$func($parameter_connect_time,$parameter_emit_time);
        }
    }
}


1;
