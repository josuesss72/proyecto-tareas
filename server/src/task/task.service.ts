import { Injectable } from '@nestjs/common';
import { CreateTaskDto } from './dto/create-task.dto';
import { UpdateTaskDto } from './dto/update-task.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserSession } from 'src/common/entities/user.entity';
import { statusResponse } from 'src/common/code-https';
import { CommonService } from 'src/common/common.service';
import { Task } from '@prisma/client';

@Injectable()
export class TaskService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly commonService: CommonService,
  ) {}
  async create(dto: CreateTaskDto, user: UserSession) {
    try {
      const task = await this.prismaService.task.create({
        data: {
          ...dto,
          user: { connect: { id: user.sub } },
        },
      });

      return {
        status: statusResponse.http201('Tarea creada exitosamente'),
        task,
      };
    } catch (error) {
      throw error;
    }
  }

  async findAll(userId: string) {
    try {
      const tasks = await this.prismaService.task.findMany({
        where: {
          user: {
            id: userId,
          },
        },
      });

      return {
        status: statusResponse.http200('Tareas obtenidas exitosamente'),
        tasks,
      };
    } catch (error) {
      throw error;
    }
  }

  async findOne(task: Task) {
    return {
      status: statusResponse.http200('Tarea obtenida exitosamente'),
      task,
    };
  }

  async update(id: string, dto: UpdateTaskDto) {
    try {
      const task = await this.prismaService.task.update({
        where: { id },
        data: dto,
      });

      return {
        status: statusResponse.http200('Tarea actualizada exitosamente'),
        task,
      };
    } catch (error) {
      throw error;
    }
  }

  async remove(id: string) {
    try {
      // Delete task
      await this.prismaService.task.delete({
        where: { id },
      });

      return {
        status: statusResponse.http200('Tarea eliminada exitosamente'),
      };
    } catch (error) {
      throw error;
    }
  }

  async removeAll(userId: string) {
    try {
      await this.prismaService.task.deleteMany({
        where: {
          user: {
            id: userId,
          },
        },
      });

      return {
        status: statusResponse.http200('Tareas eliminadas exitosamente'),
      };
    } catch (error) {
      throw error;
    }
  }
}
