import {
  Inject,
  Injectable,
  PipeTransform,
  Scope,
  UnauthorizedException,
} from '@nestjs/common';
import { REQUEST } from '@nestjs/core';
import { UserSession } from '../entities/user.entity';

@Injectable({ scope: Scope.REQUEST })
export class CheckOwnerPipe implements PipeTransform {
  constructor(@Inject(REQUEST) private readonly request: any) {}

  async transform(entity: any) {
    const session: UserSession = await this.request.user;
    const sessionId = session.sub;

    if (!sessionId || entity.userId !== sessionId) {
      throw new UnauthorizedException(
        'No tienes permiso para realizar esta accion',
      );
    }

    return entity;
  }
}
