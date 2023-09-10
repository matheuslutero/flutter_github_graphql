import 'package:app/shared/entities/user.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:app/ui/pages/user/bloc/user_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserBloc userBloc;
  late UserRepositoryMock userRepository;

  setUp(() {
    userRepository = UserRepositoryMock();
    userBloc = UserBloc(userRepository);
  });

  group('UserBloc', () {
    test('initial state is UserStateLoading', () {
      expect(userBloc.state, isA<UserStateLoading>());
    });

    blocTest<UserBloc, UserState>(
      'should handle UserEventFetch with success correctly',
      setUp: () {
        when(() => userRepository.fetchUser('testlogin1', 20)).thenAnswer(
          (_) async => const User(
            login: 'login',
            avatarUrl: 'avatarUrl',
            name: 'name',
            repositories: [],
          ),
        );
      },
      build: () => userBloc,
      act: (bloc) => bloc.add(UserEventFetch('testlogin1')),
      expect: () => [
        isA<UserStateLoading>(),
        isA<UserStateLoaded>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'should handle UserEventFetch with failure correctly',
      setUp: () {
        when(() => userRepository.fetchUser('testlogin2', 20)).thenThrow(
          Exception(),
        );
      },
      build: () => userBloc,
      act: (bloc) => bloc.add(UserEventFetch('testlogin2')),
      expect: () => [
        isA<UserStateLoading>(),
        isA<UserStateFailure>(),
      ],
    );
  });
}
