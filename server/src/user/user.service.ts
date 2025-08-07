import { Injectable } from '@nestjs/common';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { statusResponse } from 'src/common/code-https';

@Injectable()
export class UserService {
  constructor(private readonly prismaService: PrismaService) {}

  /**
   * Obtiene un usuario por su id.
   *
   * @param id - Id del usuario
   * @returns El usuario encontrado o un error si no se encuentra
   */
  async findOne(id: string) {
    try {
      const user = await this.prismaService.user.findUnique({
        where: { id },
        select: {
          id: true,
          email: true,
          name: true,
          createdAt: true,
          updatedAt: true,
        },
      });

      return {
        status: statusResponse.http200('Usuario obtenido exitosamente'),
        user,
      };
    } catch (error) {
      throw error;
    }
  }

  /**
   * Actualiza un usuario por su id.
   *
   * @param id - Id del usuario
   * @param dto - Datos del usuario a actualizar
   * @returns El usuario actualizado o un error si no se encuentra
   */
  async update(id: string, dto: UpdateUserDto) {
    try {
      const user = await this.prismaService.user.update({
        where: { id },
        data: dto,
        select: {
          id: true,
        },
      });

      return {
        status: statusResponse.http200('Usuario actualizado exitosamente'),
        user,
      };
    } catch (error) {
      throw error;
    }
  }
}
