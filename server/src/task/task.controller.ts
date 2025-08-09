import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { TaskService } from './task.service';
import { CreateTaskDto } from './dto/create-task.dto';
import { UpdateTaskDto } from './dto/update-task.dto';
import { GetUserReq } from 'src/common/decorators/get-user-req';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { UserSession } from 'src/common/entities/user.entity';
import { CheckOwnerPipe } from 'src/common/pipes/check-owner.pipe';
import { CheckExistTaskPipe } from './pipes/check-exist-task.pipe';
import { Task } from '@prisma/client';

@UseGuards(AuthGuard)
@Controller('task')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Post()
  async create(
    @Body() createTaskDto: CreateTaskDto,
    @GetUserReq() user: UserSession,
  ) {
    return await this.taskService.create(createTaskDto, user);
  }

  @Get()
  async findAll(@GetUserReq() user: UserSession) {
    return await this.taskService.findAll(user.sub);
  }

  @Get(':id')
  async findOne(@Param('id', CheckExistTaskPipe, CheckOwnerPipe) task: Task) {
    return await this.taskService.findOne(task);
  }

  @Patch(':id')
  async update(
    @Param('id', CheckExistTaskPipe, CheckOwnerPipe) task: Task,
    @Body() updateTaskDto: UpdateTaskDto,
  ) {
    return await this.taskService.update(task.id, updateTaskDto);
  }

  @Delete('delete/:id')
  async remove(@Param('id', CheckExistTaskPipe, CheckOwnerPipe) task: Task) {
    return await this.taskService.remove(task.id);
  }

  @Delete('delete-selected')
  async deleteSelected(@Body() body: { ids: string[] }) {
    return await this.taskService.deleteSelected(body.ids);
  }

  @Delete('delete-all')
  async removeAll(@GetUserReq() user: UserSession) {
    return await this.taskService.removeAll(user.sub);
  }
}
