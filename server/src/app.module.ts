import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { TaskModule } from './task/task.module';
import { UserModule } from './user/user.module';
import { CommonModule } from './common/common.module';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [PrismaModule, TaskModule, UserModule, CommonModule, AuthModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
