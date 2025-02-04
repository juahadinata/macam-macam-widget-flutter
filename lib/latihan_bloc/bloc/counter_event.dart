part of 'counter_bloc.dart';

// Event untuk increment
class IncrementEvent extends CounterEvent {}

// Event untuk decrement
class DecrementEvent extends CounterEvent {}

// Base class untuk event
abstract class CounterEvent {}
