import {
  BadRequestException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { RegisterAuthDto } from './dto/register-auth.dto';
import { LoginAuthDto } from './dto/login-auth.dto';
import * as bcryptjs from 'bcryptjs';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { statusResponse } from 'src/common/code-https';
import { CommonService } from 'src/common/common.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly jwtService: JwtService,
    private readonly commonService: CommonService,
  ) {}

  /**
   * Registra un usuario nuevo.
   *
   * @param dto contiene el email y la password del usuario
   */
  async register(dto: RegisterAuthDto) {
    const userExist = await this.commonService.findUserByEmail(dto.email);
    if (userExist) {
      throw new BadRequestException(
        `El usuario con el email ${dto.email} ya existe`,
      );
    }
    const hashPass = await bcryptjs.hash(dto.password, 10);
    const user = await this.prismaService.user.create({
      data: {
        name: dto.name,
        email: dto.email,
        password: hashPass,
      },
      select: { id: true, email: true },
    });
    return {
      status: statusResponse.http200('Usuario registrado exitosamente'),
      user,
    };
  }

  /**
   * Loguea un usuario y devuelve un token de acceso.
   *
   * @param dto contiene el email y la password del usuario
   * @param req la request express
   */
  async login(dto: LoginAuthDto, req: Request) {
    const user = await this.commonService.findUserByEmail(dto.email);

    if (!user) {
      throw new UnauthorizedException(
        `El usuario con el email ${dto.email} no existe`,
      );
    }

    // Compare the password
    const passwordMatch = await bcryptjs.compare(dto.password, user.password);
    if (!passwordMatch) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Generate token
    const payload = { email: user.email, sub: user.id };
    const token = await this.jwtService.signAsync(payload);

    req['user'] = user;

    return {
      status: statusResponse.http200('Login exitoso'),
      token,
    };
  }
}
