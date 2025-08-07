import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { Request } from 'express';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class CommonService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async findUserByEmail(email: string) {
    const user = await this.prismaService.user.findUnique({
      where: {
        email,
      },
    });

    return user;
  }

  async findTaskById(id: string, userId: string) {
    const task = await this.prismaService.task.findUnique({
      where: {
        id,
        user: {
          id: userId,
        },
      },
    });

    return task;
  }

  ExtractTokenFromHeader(request: Request): string | undefined {
    const [type, token] = request.headers.authorization?.split(' ') ?? [];
    return type === 'Bearer' ? token : undefined;
  }

  VerifyTokenExpiry(token: string): boolean {
    const objectToken = this.jwtService.decode(token);

    if (!objectToken || typeof objectToken !== 'object') {
      throw new UnauthorizedException('Token invalid');
    }

    const { exp } = objectToken;
    return Date.now() >= exp * 1000;
  }
}
