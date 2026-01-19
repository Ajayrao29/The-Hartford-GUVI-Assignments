import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {inject} from '@angular/core';
import {signal} from '@angular/core';
import {TodoService} from '../todo';
import {Todo} from '../todo.model';

@Component({
  selector: 'app-todo-list',
  imports: [CommonModule, FormsModule],
  templateUrl: './todo-list.html',
  styleUrl: './todo-list.css',
})
export class TodoList {
   private todoService = inject(TodoService);
   todos = signal<Todo[]>([])
    newTodoTitle = '';
       
    editingId =signal<number | null>(null);
    editingTitle = '';

    constructor() {
      this.loadTodos();
    }

    loadTodos() {
      this.todoService.getTodos().subscribe((todos) => {
        this.todos.set(todos);
      });

    }
    addTodo() {
      if (this.newTodoTitle.trim()) {
        const newTodo={
          title: this.newTodoTitle.trim(),
          completed: false
        };
        this.todoService.addTodo(newTodo).subscribe(() => {
          this.loadTodos();
          this.newTodoTitle = '';
        });
      }
    }
    toggleTodo(todo: Todo) {
      const updatedTodo = { ...todo, completed: !todo.completed };
      this.todoService.updateTodo(updatedTodo).subscribe(() => {
      this.loadTodos();
    });
    };
    
    deleteTodo(id: number) {
      this.todoService.deleteTodo(id).subscribe(() => {
        this.loadTodos();
      });
} 


}
