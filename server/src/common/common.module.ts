import { Module } from '@nestjs/common';
import { CommonService } from './common.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';

@Module({
  controllers: [],
  providers: [CommonService, PrismaService, JwtService],
  exports: [CommonService],
})
export class CommonModule {}
