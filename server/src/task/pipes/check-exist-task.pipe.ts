import { Injectable, NotFoundException, PipeTransform } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class CheckExistTaskPipe implements PipeTransform {
  constructor(private readonly prismaService: PrismaService) {}
  async transform(id: string) {
    const entity = await this.prismaService.task.findUnique({
      where: { id },
    });

    if (!entity) {
      throw new NotFoundException(`Task is not found with the id ${id}`);
    }

    return entity;
  }
}
